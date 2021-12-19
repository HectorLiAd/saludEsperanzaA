
import 'package:reactive_forms/reactive_forms.dart';

class _RegistroUsuarioController {
  final FormGroup registerForm= FormGroup({
    'nombres':FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
        value: ''
    ),
    'apellidos':FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
        value: ''
    ),

    'dni': FormControl<String>(
        validators: [
          Validators.required,
          Validators.number,
          Validators.maxLength(8),
          Validators.minLength(8),
        ],
        value: ''
    ),
    'user':FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(5),
          Validators.maxLength(20),
        ],
        value: ''
    ),
    'email':FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
          Validators.minLength(5),
          Validators.maxLength(60),
        ],
        value: ''
    ),
    'password':FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(8),
          Validators.maxLength(25),
          Validators.pattern(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
        ],
        value: ''
    ),
    'passwordConfirmation':FormControl<String>(value: ''),
  }, validators: [
    _mustMatch('password', 'passwordConfirmation')
  ]);

  void cleanData() {
    this.registerForm.control('nombres').reset();
    this.registerForm.control('apellidos').reset();
    this.registerForm.control('dni').reset();
    this.registerForm.control('user').reset();
    this.registerForm.control('email').reset();
    this.registerForm.control('password').reset();
    this.registerForm.control('passwordConfirmation').reset();
  }


  String get getDni => this.registerForm.control('dni').value;
  set errorDni(String value) => this.registerForm.control('dni').setErrors({value:'dni'});


  String get getUser => this.registerForm.control('user').value;
  set errorUser(String value) => this.registerForm.control('user').setErrors({value:'user'});

  String get getApellidos => this.registerForm.control('apellidos').value;
  set errorApellidos(String value) => this.registerForm.control('apellidos').setErrors({value:'apellidos'});

  String get getEmail => this.registerForm.control('email').value;
  set errorEmail(String value) => this.registerForm.control('email').setErrors({value:'email'});

  String get getNombres => this.registerForm.control('nombres').value;
  set errorNombres(String value) => this.registerForm.control('nombres').setErrors({value:'nombres'});

  String get getPassword => this.registerForm.control('password').value;
  set errorPassword(String value) => this.registerForm.control('password').setErrors({value:'password'});

}

final registroUsuarioController = _RegistroUsuarioController();




ValidatorFunction _mustMatch(String controlName, String matchingControlName) {
  return (AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({'mustMatch': true});

      // force messages to show up as soon as possible
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError('mustMatch');
    }

    return null;
  };
}