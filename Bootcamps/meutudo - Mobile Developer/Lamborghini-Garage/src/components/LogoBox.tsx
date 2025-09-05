import { View, Image } from "react-native";
import { styles } from "./Styles/LogoBoxStyle";
import Logo from '../../assets/logo.png';

export const LogoBox = () => {
    return (
        <View style={styles.logoContainer}>
            <Image style={styles.imageLogo} source={Logo} />
        </View>
    )
}