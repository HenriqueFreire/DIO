import { View, StyleSheet } from "react-native";
import { ReactNode } from "react";

const styles = StyleSheet.create({
    container:{
        flex: 1,
        width: '100%',
        backgroundColor: '#1E1E20',
        alignItems: 'center',
        justifyContent: 'center',
    },
    cameraBox:{
        borderWidth:2,
        borderColor: '#fff',
        borderRadius: 10,
        position: 'relative',
        width:300,
        height: '90%',
        overflow: 'hidden',
    },
    triangleCorner:{
        position: 'absolute',
        width: 0,
        height: 0,
        borderStyle: 'solid',
        borderTopWidth: 20,
        borderTopColor: '#fff',
        borderRightWidth: 20,
        borderRightColor: 'transparent',
    },
    topRight:{
        top:0,
        right:0,
        transform: [{rotate: '90deg'}],
    },
    bottonLeft:{
        bottom:0,
        left:0,
        transform: [{rotate: '-90deg'}],
    },
    bottonRight:{
        bottom:0,
        right:0,
        transform: [{rotate: '180deg'}],
    },
});

export const ScreenWrapper = ({ children}:{ children: ReactNode }) => {
  return (
    <View style={styles.container}>
      <View style={styles.cameraBox}>
        <View style={styles.triangleCorner}></View>
        <View style={[styles.triangleCorner, styles.topRight]}></View>
        <View style={[styles.triangleCorner, styles.bottonLeft]}></View>
        <View style={[styles.triangleCorner, styles.bottonRight]}></View>
        {children}
      </View>
    </View>
  );
}