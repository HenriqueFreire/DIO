import React, { useContext } from 'react';
import { View, Text, Button, Image } from 'react-native';
import { styles } from './Styles/CardViewStyle';
import { Divider } from './Divider';
import { LogoBox } from './LogoBox';
import { CAR_ASSETS_BASE_URL } from '../util/ConstantsCar';
import { BuyButton } from './BuyButton';


import { UserContext } from '../util/userContext';

export const CardView = () => {
    const userContext = useContext(UserContext);
    const carData = userContext?.carData;

    if (!carData) return <Text>Carregando...</Text>;

    const handleBuyButtonPress = () => {
        if (carData && userContext) {
            userContext.changeCar(carData.id, carData.carName)
        }
    };

    const renderCarDetails = () => (
        <View style={{alignItems:'center'}}>
            <Text style={styles.carBrand}>Lamborghini</Text>
            <Text style={styles.carName}>{carData?.carName}</Text>
        </View>
    )

    const renderCarImage = () => (
        <Image
            style={styles.image}
            source={{
                uri: `${CAR_ASSETS_BASE_URL}${carData?.id}.png`,
            }}
        />
    );

    const renderPriceControls = () => (
        <View style={styles.priceLabelContainer}>
            <Button title='<' color={'#01A6B3'} onPress={userContext?.handlePreviousItem} />
            <Text style={styles.priceLabel}>{carData?.price}</Text>
            <Button title='>' color={'#01A6B3'} onPress={userContext?.handleNextItem} />
        </View>
    );

    return (
        <View style={styles.imageContainer}>
            <LogoBox/>
            <Divider/>
            {renderCarDetails()}
            {renderCarImage()}
            <Divider/>
            <BuyButton onPress={handleBuyButtonPress}/>
            {renderPriceControls()}
        </View>
    );
}