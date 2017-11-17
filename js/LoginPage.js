
/**
 * Creat by dingxiankun on 17/9/20
 * Function:
 * Desc:
 */

import React, {Component} from 'react';
import {
	StyleSheet,
	View,
	Text,
	Image,
	TextInput,
	TouchableHighlight,
	Dimensions,
	AlertIOS,
} from 'react-native';

const kWidth = Dimensions.get('window').width;
const kHeight = Dimensions.get('window').height;

var loginName = "";
var password = "";

export default class LoginPage extends Component {

	constructor(props) {
		super(props);
	}

	_onPressButton() {
		console.log(loginName + '-' + password);

		let url = "http://192.168.19.102:8000/ShopCashier_SI/android/login.in";

		let formData = new FormData();
		formData.append("loginName", loginName);
		formData.append("password", password);


		fetch(url, {
			method: 'post',
			headers: {
				'Content-Type': 'application/json'
			},
			body: formData,
		})
			.then((response) => response.json())
			.then(data => console.log('data is', data))
			.catch(error => console.log('error is', error));
	}

	render() {
		return(
			<View
				style={LoginPageStyle.container}
			>
				<Image
					style={LoginPageStyle.imageStyle}
					resizeMode='repeat'
					source={require('./icon.png')}
				/>
				<TextInput
					style={LoginPageStyle.textInputStyle}
					placeholder="请输入手机号"
					onChangeText={(text) => {
						loginName = text;
						console.log(text + '-' + loginName);
					}}
				/>
				<TextInput
					style={LoginPageStyle.textInputStyle}
					placeholder="请输入密码"
					secureTextEntry={true}
					onChangeText={(text) => {
						password = text;
						console.log(text + '-' + password);
					}}
				/>
				<TouchableHighlight
					style={{marginTop: 40}}
					onPress={this._onPressButton}
				>
					<Text style={LoginPageStyle.textStyle}>登 录</Text>
				</TouchableHighlight>
			</View>
		);
	}

	componentDidMount() {

	}
}

const LoginPageStyle = StyleSheet.create({
	container: {
		flex: 1,
		flexDirection: 'column',
		// backgroundColor: 'green',
		alignItems: 'center'
	},
	imageStyle: {
		width: 80,
		height: 80,
		borderRadius: 5,
		marginTop: 100,
	},
	textInputStyle: {
		marginTop: 10,
		width: kWidth - 100,
		height: 45,
		borderColor: '#dddddd',
		borderWidth: 1,
		borderRadius: 5,
		fontSize: 15,
		padding: 15,
	},
	textStyle: {
		width: kWidth - 100,
		height: 45,
		backgroundColor: '#00bb9c',
		fontSize: 15,
		textAlign: 'center',
		color: 'white',
		paddingTop: 15,
		borderRadius: 5,
	},

});