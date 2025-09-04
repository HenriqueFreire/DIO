import React, { useContext } from 'react';
import { View, Image } from 'react-native';
import { styles } from './styles';
import { UserContext } from '../../contexts/UserContext';

export function ProfileImage() {
  const { user } = useContext(UserContext);

  return (
    <View style={styles.container}>
      <Image 
        style={styles.image}
        source={{ uri: user?.avatar_url || 'https://via.placeholder.com/150' }}
      />
    </View>
  );
}