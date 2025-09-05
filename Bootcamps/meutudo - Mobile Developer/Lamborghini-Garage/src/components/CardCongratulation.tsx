import { useContext } from "react";
import { View, Text, Image, TouchableOpacity } from "react-native";
import { styles } from "./Styles/CardCongratulationStyle";
import { CAR_ASSETS_BASE_URL } from "../util/ConstantsCar";
import { NavigationProp, useNavigation } from "@react-navigation/native";
import { RootStackParamList } from "../util/NavigationTypes";
import { UserContext } from "../util/userContext";

export const CardCongratulation = () => {
    const navigation = useNavigation<NavigationProp<RootStackParamList>>();
    const userContext = useContext(UserContext);

    return (
        <View style={styles.container}>
            <Text style={styles.title}>🎆 CONGRATULATION 🎆</Text>
            <Image
                style={styles.image}
                source={{
                    uri: `${CAR_ASSETS_BASE_URL}${userContext?.carData?.id || 1}.png`,
                }}
            />
            <Text style={styles.texto}>You are the newest owner of a</Text>
            <Text style={styles.brand}>Lamborghini</Text>
            <Text style={styles.model}>{userContext?.carData?.carName || "Avantor"}</Text>
            <TouchableOpacity onPress={() => navigation.navigate('Garage')}>
                <Text style={styles.buttonText}>Back</Text>
            </TouchableOpacity>
        </View>
    );
}