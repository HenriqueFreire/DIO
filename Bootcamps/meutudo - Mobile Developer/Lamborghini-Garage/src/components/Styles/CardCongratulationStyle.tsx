import { StyleSheet } from "react-native";

export const styles = StyleSheet.create({
    container:{
        flex: 1,
        width:'100%',
        height:'100%',
        overflow:'hidden',
        borderRadius: 8,
    },
    title:{
        fontSize:30,
        textAlign:'center',
        color:'#fff',
        padding:10,
        marginTop:10,
    },
    image:{
        flex: 1,
        resizeMode: 'contain',
        width: '100%',
        height: '100%',
        marginBottom:10,
    },
    texto:{
        fontSize:20,
        textAlign:'center',
        color:'#a08907ff',
        padding:10,
    },
    brand:{
        fontSize:40,
        fontStyle:'italic',
        textAlign:'center',
        color:'#a08907ff',
        padding:10,
    },
    model:{
        fontSize:50,
        fontWeight:'bold',
        textAlign:'center',
        color:'#a08907ff',
        padding:10,
        marginBottom:30,
    },
    buttonText:{
        color: '#fff',
        fontWeight: 'bold',
        fontStyle: 'italic',
        fontSize: 24,
        backgroundColor: '#01A6B3',
        padding: 10,
        width:'80%',
        alignItems: 'center',
        justifyContent: 'center',
        alignSelf: 'center',
        borderRadius: 8,
        textAlign:'center',
        marginBottom: 20,
    }
});