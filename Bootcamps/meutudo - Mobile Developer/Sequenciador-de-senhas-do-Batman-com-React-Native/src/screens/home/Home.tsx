import { StatusBar } from 'expo-status-bar';
import React, { useState } from 'react';
import { TouchableOpacity, View } from 'react-native';
import { styles } from './style';
import { BatLogo } from '../../components/batlogo/BatLogo';
import { BatButton } from '../../components/batbutton/BatButton';
import { BatBarButton } from '../../components/batbarbutton/BatBarButton';


export const Home = () => {
  const [isActive, setIsActive] = useState(false);
  const [passwordLength, setPasswordLength] = useState(8);

  function handleSymbol(){
    setIsActive((oldValue:boolean) => !oldValue);
  }

  function handleSetPasswordLength(lenght: number) {
    setPasswordLength(lenght);
  }

    return(
        <View style={isActive ? styles.container1 : styles.container2}>
            <BatBarButton onSelectLength={handleSetPasswordLength}/>
            <TouchableOpacity onPress={handleSymbol}>
                <View style={styles.logoContainer}>
                    <BatLogo/>
                </View>
            </TouchableOpacity>
            <View style={styles.inputContainer}>
                <BatButton passwordLength={passwordLength}/>
            </View>
            <StatusBar style="light" />
        </View>
    )
};