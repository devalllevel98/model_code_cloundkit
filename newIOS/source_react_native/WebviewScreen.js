import React, { useEffect,useRef } from "react";
import { BackHandler, View } from "react-native";
import WebView from "react-native-webview";
export default function WebviewScreen({route}){
    const {url} = route.params
    const webview = useRef(null)

    const onAndroidBackPress = () => {
        if (webview.current) {
          webview.current.goBack();
          return true; // prevent default behavior (exit app)
        }
        return false;
      };
    useEffect(() => {
        BackHandler.addEventListener('hardwareBackPress', onAndroidBackPress);
        return () => {
            BackHandler.removeEventListener('hardwareBackPress', onAndroidBackPress);
        };
    }, []); // Never re-run this effect
    return(
        <View
            style={{flex:1,paddingTop:40}}

        >
        <WebView 
            source={{ uri : url}}
            startInLoadingState={true}
            scalesPageToFit={true}

            ref={webview}
        />
        </View>
    )
}