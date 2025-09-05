import { View } from "react-native";
import { styles } from "./Styles/DividerStyles";

export const Divider = () => {
    return (
        <View style={styles.dividerContainer}>
            <View style={styles.divider}></View>
        </View>
    )
}