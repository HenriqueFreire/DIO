import { NavigationContainer, DarkTheme } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { UserContextProvider } from './src/util/userContext';
import { GarageScreen } from './src/screens/GarageScreen';
import { CongratulationScreen } from './src/screens/CongratulationScreen';
import { RootStackParamList } from './src/util/NavigationTypes';
import { StatusBar } from 'expo-status-bar';
import * as NavigationBar from 'expo-navigation-bar';
import { useEffect } from 'react';
import { Platform } from 'react-native';

const Stack = createStackNavigator<RootStackParamList>();

const MyTheme = {
  ...DarkTheme,
  colors: {
    ...DarkTheme.colors,
    background: '#1E1E20',
  },
};

const App = () => {
  useEffect(() => {
    if (Platform.OS === 'android') {
      NavigationBar.setButtonStyleAsync('light');
    }
  }, []);

  return (
    <NavigationContainer theme={MyTheme}>
      <StatusBar style="light" />
      <UserContextProvider>
        <Stack.Navigator screenOptions={{ headerShown: false }}>
          <Stack.Screen name="Garage" component={GarageScreen} />
          <Stack.Screen name="Congratulation" component={CongratulationScreen} />
        </Stack.Navigator>
      </UserContextProvider>
    </NavigationContainer>
  );
}

export default App;