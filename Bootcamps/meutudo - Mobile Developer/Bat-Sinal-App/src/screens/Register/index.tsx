import React, { useState } from 'react';
import { View } from 'react-native';
import { ImageComponent } from '../../components/ImageComponent';
import { Button } from '../../components/Button';
import { Input } from '../../components/Input';
import { TextArea } from '../../components/TextArea';
import { styles } from './styles';

export const Register = ({ navigation }) => {
  const [latitude, setLatitude] = useState('');
  const [longitude, setLongitude] = useState('');

  const handleNumericInput = (text, setter) => {
    const numericValue = text.replace(/[^0-9.-]/g, '');
    setter(numericValue);
  };

  return (
    <View style={styles.container}>
      <ImageComponent source={require('../../../assets/batman-5.svg')} width={80} height={80} />
      <Input placeholder="Seu Nome"/>
      <Input
        placeholder="Latitude"
        keyboardType="numeric"
        value={latitude}
        onChangeText={(text) => handleNumericInput(text, setLatitude)}
      />
      <Input
        placeholder="Longitude"
        keyboardType="numeric"
        value={longitude}
        onChangeText={(text) => handleNumericInput(text, setLongitude)}
      />
      <TextArea placeholder="Descrição"/>
      <Button title="Enviar para o Batman" onPress={() => navigation.navigate('SendComplete')} />
    </View>
  );
};
