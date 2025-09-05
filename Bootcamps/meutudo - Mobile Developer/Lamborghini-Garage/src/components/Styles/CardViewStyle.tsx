import { StyleSheet } from "react-native";

export const styles = StyleSheet.create({
    imageContainer: {
        flex: 1,
        width: '100%',
        height: '100%',
        overflow: 'hidden',
        borderRadius: 8,
    },
    carBrand: {
        fontSize: 18,
        fontWeight:'400',
        color: '#fff',
        fontStyle: 'italic',
    },
    carName: {
        fontSize: 20,
        color: '#fff',
        fontWeight: 'bold',
        textAlign: 'center',
    },
    image:{
        flex: 1,
        resizeMode: 'contain',
        width: '100%',
        height: '100%',
        marginBottom:10,
    },
    priceLabelContainer:{
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-around',
        paddingBottom: 10,
        marginTop: 10,
    },
    priceLabel: {
        fontSize: 22,
        color: '#fff',
    }
});