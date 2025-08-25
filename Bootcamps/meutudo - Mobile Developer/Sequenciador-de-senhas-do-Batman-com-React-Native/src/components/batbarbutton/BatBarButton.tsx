import React from 'react';
import { View, Image, TouchableOpacity } from 'react-native';
import { styles } from './BatBarButtonStyles';
import batLogo from '../../assets/bat-logo.png';
import supLogo from '../../assets/superman-logo.png';
import womLogo from '../../assets/wonder-woman-logo.png';
import flaLogo from '../../assets/flash-logo.png';
import latLogo from '../../assets/symbol-on.png';

interface BatBarButtonProps { onSelectLength: (lenght:number) => void; };

export function BatBarButton({onSelectLength}:BatBarButtonProps) {

    function handleLenght(length:number){
        onSelectLength(length);
    }

  return (
    <View style={styles.buttons}>
        <TouchableOpacity onPress={() => handleLenght(4)}>
            <Image
                source={flaLogo}
                style={styles.logo}
            />
        </TouchableOpacity>
        <TouchableOpacity onPress={() => handleLenght(6)}>
            <Image
                source={latLogo}
                style={styles.logo}
            />
        </TouchableOpacity>
        <TouchableOpacity onPress={() => handleLenght(8)}>
            <Image
                source={womLogo}
                style={styles.logo}
            />
        </TouchableOpacity>
        <TouchableOpacity onPress={() => handleLenght(10)}>
            <Image
                source={batLogo}
                style={styles.logo}
            />
        </TouchableOpacity>
        <TouchableOpacity onPress={() => handleLenght(12)}>
            <Image
                source={supLogo}
                style={styles.logo}
            />
        </TouchableOpacity>
    </View>
  );
}