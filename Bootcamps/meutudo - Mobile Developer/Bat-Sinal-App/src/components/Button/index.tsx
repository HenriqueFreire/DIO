import React from 'react';
import { TouchableOpacity, Text, Animated } from 'react-native';
import { styles } from './styles';

interface ButtonProps {
  title: string;
  onPress: () => void;
  color?: Animated.Value;
  animatedTextColor?: Animated.Value;
  animatedBorderColor?: Animated.Value;
}

export const Button: React.FC<ButtonProps> = ({ title, onPress, color, animatedTextColor, animatedBorderColor }) => {
  const buttonStyle = color ? [styles.button, { backgroundColor: color }] : styles.button;
  const textStyle = animatedTextColor ? [styles.buttonText, { color: animatedTextColor }] : styles.buttonText;
  const borderStyle = animatedBorderColor ? { borderColor: animatedBorderColor } : {};

  return (
    <TouchableOpacity onPress={onPress}>
      <Animated.View style={[buttonStyle, borderStyle]}>
        <Animated.Text style={textStyle}>{title}</Animated.Text>
      </Animated.View>
    </TouchableOpacity>
  );
};
