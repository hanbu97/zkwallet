import '../../utils/config/images.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Private Transactions",
    image: ImageRes.onboardTeam,
    desc:
        "Perform transactions with the privacy you desire, powered by zero-knowledge proofs. Maintain control and confidentiality over your transactions.",
  ),
  OnboardingContents(
    title: "Secure Wallet",
    image: ImageRes.onboardResource,
    desc:
        "Manage your assets and interact with onchain applications, all within one wallet.",
  ),
  OnboardingContents(
    title: "Regulated and Reliable",
    image: ImageRes.human,
    desc:
        "Experience a secure platform that balances regulatory oversight with privacy. Your transactions are private and compliant.",
  ),
  OnboardingContents(
    title: "Welcome to zkTransfer",
    image: ImageRes.onboardStart,
    desc:
        "Embark on a journey of privacy, security, and compliance with zkTransfer. Redefine the boundaries of crypto transactions. ",
  ),
];
