import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = ChangeNotifierProvider<OnboardingProvider>((ref) {
  return OnboardingProvider();
});

class OnboardingProvider extends ChangeNotifier {
  final controller = PageController(
    keepPage: true,
    initialPage: 0
  );

  int currentIndex = 0;
  double progress = 0.5;

  void onPageChanged(int index) {
    currentIndex = index;    
    if(index == 0) {
      progress = 0.5;
    } else {
      progress = 0.9;
    }
    notifyListeners();
  
    controller.jumpToPage(index);
  }

  List<String> selectedInterests = [];
  void addInterest(dynamic value) {
    selectedInterests.add(value);
    notifyListeners();
  }

  void removeInterest(dynamic value) {
    selectedInterests.remove(value);
    notifyListeners();
  }



  Map<String, dynamic> categories = {
    "Business": ["Startups", "Small Business", "Management", "Marketing", "Finance"],
    "Career": ["Resume Writing", "Interview Tips", "Networking", "Job Search Strategies", "Professional Skills"],
    "Travel": ["Destination Guides", "Travel Tips", "Adventure Activities", "Solo Travel", "Cultural Experiences"],
    "Leadership": ["Leadership Styles", "Team Building", "Decision Making", "Conflict Resolution", "Strategic Planning"],
    "Creativity": ["Writing", "Drawing", "Music", "Photography", "Crafts"],
    "Fashion": ["Fashion Trends", "Style Tips", "Beauty", "Fashion Design", "Personal Branding"],
    "Personal Finance & Wealth Management": ["Budgeting", "Investing", "Saving Strategies", "Retirement Planning", "Financial Independence"],
    "Food": ["Recipes", "Cooking Techniques", "Food Culture", "Healthy Eating", "Culinary Arts"],
    "Technology": ["Tech Trends", "Software Development", "Artificial Intelligence", "Blockchain", "Cybersecurity"],
    "Health & Wellness": ["Nutrition", "Exercise", "Stress Management", "Mental Health", "Sleep Hygiene"],
    "Education": ["Online Courses", "Study Tips", "Educational Resources", "Learning Strategies", "Skill Development"],
    "Fitness & Nutrition": ["Workouts", "Diet Plans", "Supplements", "Weight Loss Tips", "Healthy Eating Habits"],
    "Relationships": ["Communication Skills", "Dating Advice", "Marriage Tips", "Parenting", "Friendship"],
    "Sports": ["Sports Training", "Athlete Nutrition", "Fitness Challenges", "Sports Psychology", "Athletic Performance"],
    "Personal Growth & Self-Improvement": ["Mindset", "Goal Setting", "Productivity Hacks", "Self-Care", "Confidence Building"],
    "Entertainment": ["Movies", "TV Shows", "Books", "Gaming", "Pop Culture"],
    "Parenting & Family": ["Parenting Styles", "Child Development", "Family Activities", "Parenting Challenges", "Sibling Dynamics"],
    "Mental Health": ["Anxiety Management", "Depression Support", "Therapy", "Self-Compassion", "Mindfulness Practices"],
    "Spirituality": ["Meditation", "Yoga", "Spiritual Practices", "Gratitude", "Mindful Living"],
   
    "Social Impact": ["Volunteering", "Social Causes", "Nonprofit Organizations", "Community Engagement", "Activism"],
    
    
  };
}