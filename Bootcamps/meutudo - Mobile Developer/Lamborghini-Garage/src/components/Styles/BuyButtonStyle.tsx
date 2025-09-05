import { StyleSheet } from "react-native";

export const styles = StyleSheet.create({
    Container: {
        backgroundColor: '#01A6B3',
        padding: 10,
        width:'80%',
        alignItems: 'center',
        justifyContent: 'center',
        alignSelf: 'center',
        borderRadius: 8,
    },
    Button:{
        flexDirection:'row',
    },
    icon:{
        marginRight:10,
    },
    buttonText:{
        color: '#fff',
        fontWeight: 'bold',
        fontStyle: 'italic',
        fontSize: 24,
    }
});