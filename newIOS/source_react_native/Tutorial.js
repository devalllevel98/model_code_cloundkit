import React from 'react';
import { View,Button,Text,ImageBackground } from 'react-native';
import background2 from '../assets/background.jpeg'
export default function Tutorial({navigation}) {
  const textTutorial = "COLORFUL FUN BALLOONS is a simple game. Your task is to break the balls with one break, you will get 1 point, there will be a certain time if you don't break any ball you will lose, or if you break it black ball, you will also lose. Wish you will get high score in this game"
    React.useEffect(()=>{
        navigation.setOptions({
          headerLeft: () => (
            <Button
              onPress={() => {
                navigation.goBack();
              }}
              title="Back"
            />
          ),
          headerRight:null
        });
    },[])
    
    return(
      <ImageBackground 
          source={background2}
          resizeMode="cover" 
          style={{flex:1}}
        >
        <View
            style={{
              flex:1,
              backgroundColor: 'rgba(0,0,0, .7)',
              alignItems:'center',
              paddingHorizontal: 20
            }}
          >
            <Text 
              style={{
                paddingHorizontal:10,
                paddingTop:10,
                fontSize:20,
                color:'white',
                lineHeight:40
              }}
            >
              {textTutorial}
            </Text>
        </View>
        </ImageBackground>
    )
}