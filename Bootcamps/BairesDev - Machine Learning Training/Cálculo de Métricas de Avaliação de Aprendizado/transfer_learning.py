import tensorflow as tf
tf.config.set_visible_devices([], 'GPU')
import tensorflow_datasets as tfds
import matplotlib.pyplot as plt
from custom_callbacks import MetricsCallback

# 1. Carregar e Preparar o Dataset
# ---------------------------------

# Carrega o dataset 'cats_vs_dogs' do TensorFlow Datasets
# A divisão 'train' é separada em 80% para treino e 20% para validação.
(raw_train, raw_validation, raw_test), metadata = tfds.load(
    'cats_vs_dogs',
    split=['train[:80%]', 'train[80%:90%]', 'train[90%:]'],
    with_info=True,
    as_supervised=True,
)

# Define o tamanho para o qual as imagens serão redimensionadas
IMG_SIZE = 160 

def format_example(image, label):
    """
    Função para formatar as imagens:
    - Redimensiona para IMG_SIZE x IMG_SIZE
    - Normaliza os pixels para o intervalo [0, 1]
    """
    image = tf.cast(image, tf.float32)
    image = (image/127.5) - 1
    image = tf.image.resize(image, (IMG_SIZE, IMG_SIZE))
    return image, label

# Aplica a formatação aos datasets
train = raw_train.map(format_example)
validation = raw_validation.map(format_example)
test = raw_test.map(format_example)

# Define o tamanho do batch e embaralha os dados de treino
BATCH_SIZE = 32
SHUFFLE_BUFFER_SIZE = 1000

train_batches = train.shuffle(SHUFFLE_BUFFER_SIZE).batch(BATCH_SIZE)
validation_batches = validation.batch(BATCH_SIZE)
test_batches = test.batch(BATCH_SIZE)

# Mostra as dimensões de um batch de imagens e labels
for image_batch, label_batch in train_batches.take(1):
    pass
print("Dimensões do batch de imagens:", image_batch.shape)
print("Dimensões do batch de labels:", label_batch.shape)


# 2. Criar o Modelo com Transfer Learning
# ---------------------------------------

# Carrega o modelo base: MobileNetV2 pré-treinado no ImageNet
# `include_top=False` para não incluir a camada de classificação final
IMG_SHAPE = (IMG_SIZE, IMG_SIZE, 3)
base_model = tf.keras.applications.MobileNetV2(input_shape=IMG_SHAPE,
                                               include_top=False,
                                               weights='imagenet')

# Congela o modelo base para não treinar seus pesos
base_model.trainable = False

# Adiciona um cabeçalho de classificação personalizado
global_average_layer = tf.keras.layers.GlobalAveragePooling2D()
prediction_layer = tf.keras.layers.Dense(1)

model = tf.keras.Sequential([
    base_model,
    global_average_layer,
    prediction_layer
])

# 3. Compilar e Treinar o Modelo
# ------------------------------

# Compila o modelo com um otimizador, função de perda e métricas
base_learning_rate = 0.0001
model.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=base_learning_rate),
              loss=tf.keras.losses.BinaryCrossentropy(from_logits=True),
              metrics=['accuracy'])

print("\nResumo do modelo antes do treinamento:")
model.summary()

# Treina o modelo por 10 épocas
initial_epochs = 10
metrics_callback = MetricsCallback(validation_data=validation_batches)
history = model.fit(train_batches,
                    epochs=initial_epochs,
                    validation_data=validation_batches,
                    callbacks=[metrics_callback])


# 4. Avaliar o Modelo
# -------------------

acc = history.history['accuracy']
val_acc = history.history['val_accuracy']

loss = history.history['loss']
val_loss = history.history['val_loss']

# Salva um gráfico da acurácia e perda ao longo do treinamento
plt.figure(figsize=(8, 8))
plt.subplot(2, 1, 1)
plt.plot(acc, label='Acurácia de Treino')
plt.plot(val_acc, label='Acurácia de Validação')
plt.legend(loc='lower right')
plt.ylabel('Acurácia')
plt.ylim([min(plt.ylim()),1])
plt.title('Acurácia de Treino e Validação')

plt.subplot(2, 1, 2)
plt.plot(loss, label='Perda de Treino')
plt.plot(val_loss, label='Perda de Validação')
plt.legend(loc='upper right')
plt.ylabel('Cross Entropy')
plt.ylim([0,1.0])
plt.title('Perda de Treino e Validação')
plt.xlabel('época')
plt.savefig('training_history.png')

print("\nGráfico do histórico de treinamento salvo como 'training_history.png'")

# Avalia o modelo no conjunto de teste
loss, accuracy = model.evaluate(test_batches)
print("\nAcurácia no conjunto de teste: {:.2f}%".format(accuracy * 100))