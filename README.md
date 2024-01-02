# notepad

A new Flutter project.

This project base on Firebase. 
This project Feature are :

		1.Splesh Screen use AnimatedTextkit or Lottie animation
		2. Login use Firebase
		3. SigUp use firebase
		4. Home page Show task use fire base
		5. Add task page use fire base
		6.Show Task Screen view
		7.Task Edit use firebase
		8. Task Delete use firebase

  
1.Splesh Screen use AnimatedTextkit or Lottie animation:

 ![Screenshot_64](https://github.com/riShad241/Notepad/assets/106663161/947753d3-4b2c-4f1e-add0-11dc88b9d230)
  
This splesh Screen i use a method which is , If user First Time open this app this time First time show splesh screen then navigate to Log in screen then go to Home Screen . If user already login this app then user open this app first show Spelsh screen then go to home screen.

			 void gotoLogInScreen() {
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => user != null? HomePage():LogInScreen(showLoginPage: () {})),(route) => false,));
  }

 2. Login use Firebase:
    
![Screenshot_65](https://github.com/riShad241/Notepad/assets/106663161/a7ae5621-fb11-40c6-bc2c-0ec747e3395e)

3. SigUp use firebase:
   
![Screenshot_66](https://github.com/riShad241/Notepad/assets/106663161/ef18f3eb-560f-4688-98f7-f9bd790a499f)

4. Home page Show task use fire base:
![Screenshot_67](https://github.com/riShad241/Notepad/assets/106663161/499e4fe7-679d-45c3-9af6-fc6a3c59fb67)
![Screenshot_68](https://github.com/riShad241/Notepad/assets/106663161/4c018a31-c4e8-448e-bd89-fe6d92c79086)



