import React from 'react';
import { TouchableOpacity, Text, View } from 'react-native';
import { styles } from './styles';
import { FontAwesome } from '@expo/vector-icons';

interface ButtonProps {
  title: string;
  onPress: () => void;
  iconName?: keyof typeof FontAwesome.glyphMap; // Nome do ícone opcional
}

export function Button({ title, onPress, iconName }: ButtonProps) {
  return (
    <TouchableOpacity style={styles.button} onPress={onPress}>
      <View style={styles.buttonContent}>
        {iconName && <FontAwesome name={iconName} style={styles.icon} />}
        <Text style={styles.buttonText}>{title}</Text>
      </View>
    </TouchableOpacity>
  );
}