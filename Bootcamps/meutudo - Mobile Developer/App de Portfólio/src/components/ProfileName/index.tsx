import React, { useContext } from 'react';
import { View, Text } from 'react-native';
import { styles } from './styles';
import { UserContext } from '../../contexts/UserContext';

export function ProfileName() {
  const { user } = useContext(UserContext);

  return (
    <View style={styles.container}>
      <Text style={styles.name}>{user?.name}</Text>
    </View>
  );
}