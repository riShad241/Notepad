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
