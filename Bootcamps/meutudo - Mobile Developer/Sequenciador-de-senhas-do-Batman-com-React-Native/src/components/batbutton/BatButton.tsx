import React, { useState } from 'react';
import { Text, Pressable } from 'react-native';
import * as Clipboard from 'expo-clipboard';
import { BatTextInput } from '../battextinput/BatTextInput';
import { styles } from './BatButtonStyles';
import { generatePass } from '../../services/passwordService';

interface BatButtonProps { passwordLength: number; }

export function BatButton({passwordLength}:BatButtonProps) {
  const [pass, setPass] = useState('');

  function handleGeneratorButton(){
    let generateToken = generatePass(passwordLength);
    setPass(generateToken);
  }

  function handleCopyButton(){
    Clipboard.setStringAsync(pass);
  }

  return (
    <>
        <BatTextInput pass={pass}/>
        <Pressable 
          onPress={handleGeneratorButton}
          style={styles.Button}
        >
          <Text style={styles.Text}>GENERATOR</Text>
        </Pressable>
        <Pressable 
          onPress={handleCopyButton}
          style={styles.Button}
        >
          <Text style={styles.Text}>🪄 COPY 🪄</Text>
        </Pressable>
    </>
  );
}