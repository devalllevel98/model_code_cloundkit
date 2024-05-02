import React from "react";
import { View } from "react-native";
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SplashScreen from "./screens/SplashScreen";
import App from "./App";
import Home from "./screens/HomeScreen";
import Tutorial from "./screens/Tutorial";
const Stack = createStackNavigator();

export default function Main(){

    return(
        <NavigationContainer>
            <Stack.Navigator initialRouteName="SplashScreen">
                <Stack.Screen name="Home" component={Home} options={{headerShown:false}}/>
                <Stack.Screen name="PlayGame" component={App} />
                <Stack.Screen name="SplashScreen" component={SplashScreen} options={{headerShown:false}}/>
                <Stack.Screen name="Tutorial" component={Tutorial}/>
            </Stack.Navigator>
        </NavigationContainer>
    )
}