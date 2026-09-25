import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthCubit>().register(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // =========================
          // SUCCESS
          // =========================
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Account created successfully 🎉',
                ),
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
                  (route) => false,
            );
          }

          // =========================
          // ERROR
          // =========================
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'Registration failed',
                ),
              ),
            );
          }
        },

        // =========================
        // UI
        // =========================
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
              centerTitle: true,
            ),

            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // =========================
                      // ICON
                      // =========================
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 80,
                        color: Colors.blue,
                      ),

                      const SizedBox(height: 25),

                      // =========================
                      // TITLE
                      // =========================
                      const Text(
                        'Create Account ✨',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Create a new account to get started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 35),

                      // =========================
                      // EMAIL
                      // =========================
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your email';
                          }

                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // =========================
                      // PASSWORD
                      // =========================
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword =
                                !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your password';
                          }

                          if (value.trim().length < 6) {
                            return 'Password must be at least 6 characters';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // =========================
                      // CONFIRM PASSWORD
                      // =========================
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Enter your password again',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureConfirmPassword =
                                !obscureConfirmPassword;
                              });
                            },
                            icon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please confirm your password';
                          }

                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      // =========================
                      // REGISTER BUTTON
                      // =========================
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => register(context),
                          child: isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                              : const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // =========================
                      // GO TO LOGIN
                      // =========================
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const LoginPage(),
                                ),
                              );
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}