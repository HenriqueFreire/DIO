import React from 'react';
import { View } from 'react-native';
import { Button } from '../../components/Button';
import { ImageComponent } from '../../components/ImageComponent';
import { styles } from './styles';

export const Home = ({ navigation }) => {
  return (
    <View style={styles.container}>
      <ImageComponent source={require('../../../assets/batman-5.svg')} width={200} height={200} />
      <Button title="Ativar Bat-Sinal" onPress={() => navigation.navigate('Register')} />
    </View>
  );
};


