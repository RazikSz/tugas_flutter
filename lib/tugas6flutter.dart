// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // jangan lupa add package

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController(text: 'Jidan12@gmail.com');
//   final _phoneController = TextEditingController(text: '+6285234676642');
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/24.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),

//                 // Welcome Text pakai Poppins
//                 Text(
//                   "Welcome Back",
// style: GoogleFonts.poppins(
//     fontSize: 26,
//     fontWeight: FontWeight.w700,
//     color: Colors.black, // ganti putih biar kontras
//   ),
// ),
// const SizedBox(height: 16),
// Text(
//   "Login to access your account",
//   style: GoogleFonts.poppins(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: Colors.grey,
//   ),
// ),
//                 const SizedBox(height: 32),

//                 // Email
//                 _buildLabel("Email Address"),
//                 const SizedBox(height: 19),
//                 _buildTextField(
//                   controller: _emailController,
//                   hint: "Jidan12@gmail.com",
//                   keyboardType: TextInputType.emailAddress,
//                   isPassword: false, // email bukan password
//                 ),
//                 const SizedBox(height: 27),

//                 // Phone
//                 _buildLabel("Phone Number"),
//                 const SizedBox(height: 19),
//                 _buildTextField(
//                   controller: _phoneController,
//                   hint: "+6285234676642",
//                   keyboardType: TextInputType.phone,
//                   isPassword: false, // phone bukan password
//                 ),
//                 const SizedBox(height: 27),

//                 // Password
//                 _buildLabel("Password"),
//                 const SizedBox(height: 19),
//                 _buildTextField(
//                   controller: _passwordController,
//                   hint: "••••••••••••",
//                   obscureText: _obscurePassword,
//                   isPassword: true,
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscurePassword
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility_outlined,
//                       color: const Color(0xFFC4C4C4), //
//                       size: 26,
//                     ),
//                     onPressed: () =>
//                         setState(() => _obscurePassword = !_obscurePassword),
//                   ),
//                 ),

//                 // Forgot Password
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: Color(0xFFF34B1B),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),

//                 // Login Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 63,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF283FB1), // tombol putih
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       elevation: 2,
//                     ),
//                     onPressed: () {
//                       // aksi login
//                     },
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 19,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // Or Sign In With
//                 Row(
//                   children: [
//                     Expanded(child: Divider(color: Colors.white, thickness: 1)),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         "Or Sign In With",
//                         style: TextStyle(color: Colors.grey, fontSize: 15),
//                       ),
//                     ),
//                     Expanded(child: Divider(color: Colors.white, thickness: 1)),
//                   ],
//                 ),
//                 const SizedBox(height: 32),

//                 // Google Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 58,
//                   child: OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       side: const BorderSide(color: Colors.white),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       elevation: 0,
//                     ),
//                     onPressed: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.network(
//                           'https://www.google.com/favicon.ico',
//                           height: 20,
//                           width: 20,
//                           errorBuilder: (_, _, _) => const Icon(
//                             Icons.g_mobiledata,
//                             size: 24,
//                             color: Colors.red,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         const Text(
//                           "Google",
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // Sign Up
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Don't have an account? ",
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: const Text(
//                         "Sign Up",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 68, 0, 255),
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(
//           fontSize: 13,
//           fontWeight: FontWeight.w500,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     TextInputType? keyboardType,
//     bool obscureText = false,
//     Widget? suffixIcon,
//     required bool isPassword,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       style: isPassword
//           // kalau password pakai Arimo + #222, size gede + bold
//           ? GoogleFonts.arimo(
//               color: const Color(0xFF222222),
//               fontSize: 20, // digedein
//               fontWeight: FontWeight.w700, // dibold
//               letterSpacing: 1,
//             )
//           : const TextStyle(color: Colors.black87, fontSize: 16),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: isPassword
//             // hint password pakai Arimo + #222, size gede + bold
//             ? GoogleFonts.arimo(
//                 color: Colors.black,
//                 fontSize: 18, // digedein
//                 fontWeight: FontWeight.bold, // dibold
//                 letterSpacing: 2, // biar titiknya agak renggang
//               )
//             : TextStyle(color: Colors.grey[500]),
//         filled: true,
//         fillColor: Colors.white.withValues(alpha: 0.95),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 18,
//           vertical: 15,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(28),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(28),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(26),
//           borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
//         ),
//         suffixIcon: suffixIcon,
//       ),
//     );
//   }
// }
