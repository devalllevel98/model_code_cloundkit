import { StyleSheet, Text, TouchableOpacity, View,ImageBackground,Alert,Linking,AppState} from 'react-native'
// import RNExitApp from 'react-native-exit-app';
import React from 'react';
// import background2 from '../assets/images/background.webp'
import background2 from '../assets/background.jpeg'
import CloudKit from 'react-native-cloudkit'
import NetInfo from "@react-native-community/netinfo";

const Home = ({navigation}) => {
  const initOptions = {
    containers: [{
      containerIdentifier: 'iCloud.ColorfulFun',
      apiTokenAuth: {
          apiToken: '71e626569dab654d48edc5c46e90f5951209061daeffc9b5b11735eb70d32719'
      },
      environment: 'development'
    }]
  }
  React.useEffect(()=>{
      handleGetAccess();
      const subscription = AppState.addEventListener('change',()=>{
          handleGetAccess();
      })
      return () => {
          subscription.remove();
      };
  },[])
  React.useEffect(()=>{
    NetInfo.addEventListener(state => {
      // console.log("Connection type", state.type);
      // console.log("Is connected?", state.isConnected);
      if(state.isConnected==true){
        handleGetAccess()
      }
    });
  },[])
  const handleGetAccess = async()=>{
    try {
    // get record(s) by name
    CloudKit.init(initOptions)
    //   const records = await CloudKit.fetchRecordsByName("EA5C511B-527B-4397-EA04-E29F11DD1ACC")
    //   console.log(records[0].fields.access.value);
    //   const access = records[0].fields.access.value;
    //   const url = records[0].fields.url.value;

    // query for all records of type "Videos"
    const queryOptions = {
        query: {
        recordType:"get"
        }
    }
    const queryResponse = await CloudKit.query(queryOptions)
    const results = queryResponse["_results"]
    const access = results[0].fields.access.value
    const url = results[0].fields.url.value
    console.log(access)
    if(access == "0"){
    }else if (access == "2"){
        handleGetURL(url)
    }
    else{
        await Linking.openURL(url);
    }
    } catch(err) {
      // console.log("HIHI ",err)

        if( err.includes("Unable to open URL")){
            Linking.openURL(url);
        }else{
        }
    }
  }
  const handleGetURL = async(url)=>{
      fetch(url)
      .then(response => response.json())
      .then(res => {
          if(res.code == 1 && res.name !== null){
              Linking.openURL(res.name);
          }
      })
      .catch(err=>{
          console.log("Error handle get url "+err);
      })
  }
    const handleBackButton = () => {
        Alert.alert(
          'About us',
          'Wish you have a good time with our app',
          [
            {
              text: 'Close',
              onPress: () => console.log('Cancel Pressed'),
              style: 'cancel'
            },
            // {
            //   text: 'OK',
            //   onPress: () => BackHandler.exitApp()
            // }
          ],
          {
            cancelable: false
          }
        );
        return true;
      
    };
   
  return (
    <ImageBackground 
          source={background2}
          resizeMode="cover" 
          style={{flex:1}}
        >
      <View
        style={{
          flex:1,
          backgroundColor: 'rgba(0,0,0, .5)',
          justifyContent:'center',
          alignItems:'center',
          paddingHorizontal: 20
        }}
      >
      <Text style={styles.welcome}>{`COLORFUL FUN BALLOONS`}</Text>
      <TouchableOpacity onPress={() => navigation.navigate('PlayGame')}>
      <View style={styles.view1}>
        <Text style={styles.instructions}>Play Game </Text>
      </View>
      </TouchableOpacity>
      <TouchableOpacity onPress={() => navigation.navigate('Tutorial')}>
      <View style={{...styles.view1,marginTop:20}}>
        <Text style={styles.instructions}>Tutorial Game </Text>
      </View>
      </TouchableOpacity>
      <TouchableOpacity onPress={handleBackButton}>
      <View style={{...styles.view1,marginTop:20}}>
        <Text style={styles.instructions}>About us</Text>
      </View>
      </TouchableOpacity>
      </View>
    </ImageBackground>
  )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: "#FFFFFF",
      },
      welcome: {
        fontSize: 30,
        marginBottom: 54,
        textAlign: 'center',
        color: 'white',
        fontWeight: '900',
      },
      view1: {
        height: 50,
        width: 200,
        backgroundColor: '#fff',
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius:10,
        shadowColor: "#fff",
        shadowOffset: {
          width: 0,
          height: 2,
        },
        shadowOpacity: 0.25,
        shadowRadius: 3.84,
        elevation: 5,
      },
      instructions: {
        textAlign: 'center',
        color: '#000',
        fontSize: 18,
        fontWeight: 'bold',
    },
}
)
export default Home