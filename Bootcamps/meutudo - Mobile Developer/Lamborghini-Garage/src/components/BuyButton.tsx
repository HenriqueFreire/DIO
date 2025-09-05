import { View, TouchableOpacity, Text } from 'react-native';
import { styles } from './Styles/BuyButtonStyle';
import { AntDesign } from '@expo/vector-icons';
import { useNavigation, NavigationProp } from '@react-navigation/native';
import { RootStackParamList } from '../util/NavigationTypes'

interface BuyButtonProps {
    onPress: () => void;
}

export const BuyButton = ({onPress}:BuyButtonProps) => {
    const navigation = useNavigation<NavigationProp<RootStackParamList>>();

    const handlePress = () => {
        onPress();
        navigation.navigate('Congratulation');
    }

    return (
        <View style={styles.Container}>
            <TouchableOpacity style={styles.Button} onPress={handlePress}>
                <AntDesign name="shoppingcart" size={24} color="white" style={styles.icon} />
                <Text style={styles.buttonText}> Buy Now</Text>
            </TouchableOpacity>
        </View>
    );
}