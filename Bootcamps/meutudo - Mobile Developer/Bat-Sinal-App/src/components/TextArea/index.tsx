import React from 'react';
import { TextInput, TextInputProps } from 'react-native';
import { styles } from './styles';

interface TextAreaProps extends TextInputProps {}

export const TextArea: React.FC<TextAreaProps> = (props) => {
  return (
    <TextInput
      style={styles.textArea}
      multiline={true}
      numberOfLines={4}
      {...props}
    />
  );
};
