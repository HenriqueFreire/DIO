
import os
os.environ['CUDA_VISIBLE_DEVICES'] = '-1'
import tensorflow as tf
import keras
import shutil

def train_model(data_dir, selected_classes, model_save_path, epochs=10, batch_size=32, img_height=224, img_width=224):
    """
    Carrega dados, constrói e treina um modelo de classificação de imagens
    usando transfer learning com VGG16.
    """
    # 1. Preparar um diretório de dados temporário com as classes selecionadas
    temp_data_dir = "temp_data_for_training"
    if os.path.exists(temp_data_dir):
        shutil.rmtree(temp_data_dir)
    
    for class_name in selected_classes:
        shutil.copytree(os.path.join(data_dir, class_name), os.path.join(temp_data_dir, class_name))
    
    print(f"Dados das classes {selected_classes} copiados para {temp_data_dir}")

    # 2. Carregar os dados
    print("Carregando e dividindo o dataset...")
    train_ds = keras.utils.image_dataset_from_directory(
        temp_data_dir,
        validation_split=0.2,
        subset="training",
        seed=123,
        image_size=(img_height, img_width),
        batch_size=batch_size
    )

    val_ds = keras.utils.image_dataset_from_directory(
        temp_data_dir,
        validation_split=0.2,
        subset="validation",
        seed=123,
        image_size=(img_height, img_width),
        batch_size=batch_size
    )

    class_names = train_ds.class_names
    print(f"Classes encontradas para o treinamento: {class_names}")

    # Otimização de performance
    AUTOTUNE = tf.data.AUTOTUNE
    train_ds = train_ds.cache().shuffle(1000).prefetch(buffer_size=AUTOTUNE)
    val_ds = val_ds.cache().prefetch(buffer_size=AUTOTUNE)

    # 3. Construir o modelo (Transfer Learning)
    print("Construindo o modelo com base no VGG16...")
    base_model = keras.applications.VGG16(
        input_shape=(img_height, img_width, 3),
        include_top=False,
        weights='imagenet'
    )
    base_model.trainable = False # Congela a base

    # Adiciona um novo cabeçalho de classificação
    inputs = keras.Input(shape=(img_height, img_width, 3))
    x = keras.applications.vgg16.preprocess_input(inputs)
    x = base_model(x, training=False)
    x = keras.layers.GlobalAveragePooling2D(name="feature_extraction_layer")(x)
    x = keras.layers.Dense(128, activation='relu')(x)
    outputs = keras.layers.Dense(len(class_names), activation='softmax')(x)
    
    model = keras.Model(inputs, outputs)

    # 4. Compilar e treinar o modelo
    print("Compilando e iniciando o treinamento...")
    model.compile(
        optimizer='adam',
        loss=keras.losses.SparseCategoricalCrossentropy(),
        metrics=['accuracy']
    )

    model.summary()

    history = model.fit(
        train_ds,
        validation_data=val_ds,
        epochs=epochs
    )

    # 5. Salvar o modelo treinado
    print(f"Salvando o modelo treinado em: {model_save_path}")
    model.save(model_save_path)
    
    # 6. Limpar o diretório temporário
    shutil.rmtree(temp_data_dir)
    print(f"Diretório temporário {temp_data_dir} removido.")

if __name__ == '__main__':
    CLASSES = ['laptop', 'watch', 'cellphone', 'cup']
    DATA_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'data', '101_ObjectCategories'))
    MODEL_PATH = "fine_tuned_model.keras"
    
    if os.path.exists(MODEL_PATH):
        print(f"Modelo {MODEL_PATH} já existe. Pulando o treinamento.")
    else:
        train_model(DATA_DIR, CLASSES, MODEL_PATH)
