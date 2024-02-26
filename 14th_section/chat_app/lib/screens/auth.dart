import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/user_image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isUploading = false;
  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;
  String _enteredEmail = '';
  String _enteredPasword = '';
  String _enteredUsername = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    if (!_isLogin && _selectedImage == null) {
      _showMessage('Please, pick image.');
      return;
    }

    _formKey.currentState!.save();

    setState(() => _isUploading = true);
    try {
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPasword,
        );
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPasword,
        );

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            'username': _enteredUsername,
            'email': _enteredEmail,
            'image_url': imageUrl,
          },
        );
      }

      setState(() => _isUploading = false);
    } on FirebaseAuthException catch (error) {
      setState(() => _isUploading = false);
      if (!context.mounted) return;

      _showMessage(error.message ?? 'Authentification failed.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          UserImagePicker(
                            onImagePicked: (pickedImage) =>
                                _selectedImage = pickedImage,
                          ),
                        if (!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            enableSuggestions: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Write username';
                              }

                              final trimedValue = value.trim();

                              if (trimedValue.length < 4) {
                                return 'Must be equal or higer than 4';
                              }

                              if (trimedValue.length > 50) {
                                return 'Must be equal or lower than 50';
                              }

                              return null;
                            },
                            onSaved: (value) =>
                                _enteredUsername = value!.trim(),
                          ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Write email';
                            }

                            final trimedValue = value.trim();
                            RegExp emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );

                            if (trimedValue.length > 50) {
                              return 'Must be equal or lower than 50';
                            }

                            if (trimedValue.isEmpty ||
                                !emailRegex.hasMatch(value)) {
                              return 'Write valid email';
                            }

                            return null;
                          },
                          onSaved: (value) => _enteredEmail = value!.trim(),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Write password';
                            }

                            if (value.length < 6) {
                              return 'Must be equal or higer than 6';
                            }

                            if (value.length > 30) {
                              return 'Must be equal or lower than 30';
                            }

                            return null;
                          },
                          onSaved: (value) => _enteredPasword = value!,
                        ),
                        const SizedBox(height: 16),
                        if (_isUploading) const CircularProgressIndicator(),
                        if (_isUploading) const SizedBox(height: 10),
                        if (!_isUploading)
                          ElevatedButton(
                            onPressed: _isUploading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                        if (!_isUploading)
                          TextButton(
                            onPressed: _isUploading
                                ? null
                                : () => setState(() => _isLogin = !_isLogin),
                            child: Text(
                              _isLogin
                                  ? 'Create an account'
                                  : 'I already have an account',
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
