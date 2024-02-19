puts "****************************** Started creating explanation text records ***********************"

ExplanationText = BxBlockExplanationText::ExplanationText

## sign up
ExplanationText.find_or_create_by(section_name: 'Sign Up', value: "You are almost there. Head over to your email inbox, verify your account and unlock the app by opening the email we just sent you.") unless ExplanationText.find_by(section_name: 'Sign Up').present?

## Skin Quiz
ExplanationText.find_or_create_by(section_name: 'Start of skin quiz', value: "Skin Quiz This short quiz is perfect as the first stop to get you started on your journey to beautiful, healthy skin for a lifetime." +
  "At the end of the quiz, you'll have the option to purchase your new skincare routine based on your answers." +
  "We want this to be a journey that will deliver results and achieve all your skin goals. Become a Glowgetter for full access to our Skin Hub.") unless ExplanationText.find_by(section_name: 'Start of skin quiz').present?

ExplanationText.find_or_create_by(section_name: 'End of skin quiz', value: "Well done you have completed our quiz and taken your first step to skin health." +
  "Okay [name], you have [normal skin] with some concerns. It's important to feed your skin orally and topically, what it needs to be healthy.") unless ExplanationText.find_by(section_name: 'End of skin quiz').present?

ExplanationText.find_or_create_by(section_name: 'Advanced Routine', area_name: "screen_header", value: "Advanced Routine for [Normal Skin]" +
  "Congratulations on choosing skin health. We want to be a part of your journey to support you and guide you."+
  "Become a Glowgetter today by arranging an Online Skin Consultation with our team or subscribing to our app.") unless ExplanationText.find_by(section_name: 'Advanced Routine', area_name: "screen_header").present?

ExplanationText.find_or_create_by(section_name: 'Advanced Routine', area_name: "screen_footer", value: "Glowgetters Glowgetters are unique group of people who are passionate about healthy skin." +
  "Join today and you will become part of our hub where you will gain access to educational tutorials, your skin diary, and open chat forums.") unless ExplanationText.find_by(section_name: 'Advanced Routine', area_name: "screen_footer").present?

ExplanationText.find_or_create_by(section_name: 'Basic Routine', area_name: "screen_header", value: "Basic Routine for [Normal Skin]" +
  "Feed skin topically, fuel skin with supplements and protect with SPF.") unless ExplanationText.find_by(section_name: 'Basic Routine', area_name: "screen_header").present?

ExplanationText.find_or_create_by(section_name: 'Basic Routine', area_name: "screen_footer", value: "Glowgetters We want to guide you on your journey and help you achieve your skin goals in the shortest time frame possible." +
  "Become a Glowgetter and track your journey, get unlimited support and advice in our open chat forums and a Skin Expert at a tap of a button.") unless ExplanationText.find_by(section_name: 'Basic Routine', area_name: "screen_footer").present?

ExplanationText.find_or_create_by(section_name: 'Skin Stories', value: "Our Skin Stories For over 40 years we have educated and empowered hundreds of people on how to have beautiful, healthy skin for a lifetime." +
  "We have changed many lives with our holistic approach to skin health and brought our clients on a journey where they get to enjoy a renewed confidence and appreciation for their skin.") unless ExplanationText.find_by(section_name: 'Skin Stories').present?

ExplanationText.find_or_create_by(section_name: 'Track Your Skin', value: "Track Your Skin Ensure bright light source in front of you. Ensure you're against a plain background. No hair overing your face or forehead. No shadows on your face. No camera filters.") unless ExplanationText.find_by(section_name: 'Track Your Skin').present?

ExplanationText.find_or_create_by(section_name: 'End of skin log', value: "You are a day closer to healthy skin. Keep working towards your skin goals with daily logs and weekly photos. Please take photos on the same day of each week, in good light.") unless ExplanationText.find_by(section_name: 'End of skin log').present?

ExplanationText.find_or_create_by(section_name: 'Export skin diary', value: "Share your journey You will achieve your goals fastest when supported. Track your journey and share it with your skincare professional") unless ExplanationText.find_by(section_name: 'Share your journey').present?

ExplanationText.find_or_create_by(section_name: 'My Plan', area_name: 'screen_header', value: "Here's free trial for Skin Deep Glowgetters. Cancel Anytime. Track your skin journey. Get unlimited support & advice. Open chat forums. Skin experts at the tap of a button. Access to our skin hub with educational tutorials and blogs."+
  "Select a plan to start your free trial. Available to new Glowgetter users only. User are limited to one free trial only. After the trial, you will be billed. You can change plans or cancel anytime.") unless ExplanationText.find_by(section_name: 'My Plan', area_name: 'screen_header').present?

ExplanationText.find_or_create_by(section_name: 'My Plan', area_name: 'screen_footer', value: "You can cancel or manage your subscription in iTunes settings, Your free trial will convert to an auto-renewing monthly or annual, as applicable, paid subscription unless you cancel at least 24 hours before the trial period or then-current subscription period ends." +
  "By upgrading to Glowgetters you acknowledge and agree that your subscription is subject to our Terms and Conditions and Privacy Policy.") unless ExplanationText.find_by(section_name: 'My Plan', area_name: 'screen_footer').present?

ExplanationText.find_or_create_by(section_name: 'Delete Account', value: "Delete Account Are you sure you want to delete your skin deep profile?") unless ExplanationText.find_by(section_name: 'Delete Account').present?

ExplanationText.find_or_create_by(section_name: 'Log out', value: "Log out Are you sure you want to log out?") unless ExplanationText.find_by(section_name: 'Log out').present?

ExplanationText.find_or_create_by(section_name: 'Life Event Info', value: "Important date comping up? Let's celebrate with beautiful skin! Add any impending special event to your profile so we can share it with you.") unless ExplanationText.find_by(section_name: 'Life Event Info').present?

ExplanationText.find_or_create_by(section_name: 'Life Event', value: "Something special going on in your life? Add it to your profile - your skin journey with us is all about supporting, uplifting and celebrating with you.") unless ExplanationText.find_by(section_name: 'Life Event').present?

ExplanationText.find_or_create_by(section_name: 'Pregnancy', value: "Expecting a baby? Pregnancy can alter the treatments and care your skin requires. Add your pregnancy to your profile so we can support and advice your skincare journey accordingly.") unless ExplanationText.find_by(section_name: 'Pregnancy').present?

ExplanationText.find_or_create_by(section_name: 'Wedding', value: "Bride or groom to be? Let us help celebrate one of the most important days of your life by getting you on your journey to gorgeous, healthy skin. Add your wedding date to your profile.") unless ExplanationText.find_by(section_name: 'Wedding').present?

ExplanationText.find_or_create_by(section_name: 'Birthday', value: "It's your birthday! Celebrate another year of being fabulous by fast-tracking your journey to healthy, glowing skin. Add your birthday to your profile so we can mark the occasion with you.") unless ExplanationText.find_by(section_name: 'Birthday').present?

ExplanationText.find_or_create_by(section_name: 'Wallet From Profile', value: "Save with Skin Deep. Saving a little along the way with regular transfers takes the pinch out of skin care.") unless ExplanationText.find_by(section_name: 'Wallet From Profile').present?

ExplanationText.find_or_create_by(section_name: 'Skin Care Routine', value: "We want to guide you on your journey and help you achieve your goals in the shortest time frame possible." +
  "Book a consultation and become a Glowgetter. Track your journey, get unlimited support and advice in our open chat forums and speak with a Skin Expert at a tap of a button.") unless ExplanationText.find_by(section_name: 'Skin Care Routine').present?

ExplanationText.find_or_create_by(section_name: 'Glowgetter User Skin Care Routine', area_name: 'screen_header', value: "Our Skin Experts are here to guide you on your journey to Skin Health." +
  "Our aim is to achieve your goals in the shortest time frame while educating you on how to have beautiful healthy skin for a life time.") unless ExplanationText.find_by(section_name: 'Glowgetter User Skin Care Routine', area_name: 'screen_header').present?

ExplanationText.find_or_create_by(section_name: 'Glowgetter User Skin Care Routine', area_name: 'screen_footer', value: "Don't forget! Fask track your results by tracking your journey on our skin diary. Log photos weekly so we can see how ") unless ExplanationText.find_by(section_name: 'Glowgetter User Skin Care Routine', area_name: 'screen_footer').present?

ExplanationText.find_or_create_by(section_name: 'Supplements', value: "Supplements to get you closer to your Skin Goals" +
  "Please note all Supplements should be taken with food and you should avoid Hot Drinks for 40 mins after taking your Supplements.") unless ExplanationText.find_by(section_name: 'Supplements').present?

ExplanationText.find_or_create_by(section_name: 'Wallet', value: "Save with Skin Deep Use your account to save funds and spread the costs over the year." +
  "Choose the amount and the frequency that works best for you.") unless ExplanationText.find_by(section_name: 'Wallet').present?

ExplanationText.find_or_create_by(section_name: 'Glow Gift', value: "Gifting Made Easy The greatest gift you can give someone is your time but if you have very little, send them the gift of healthy skin. Transfer glow gift funds today." +
  "Set the amount you'd like to give. Add a personal message so they know it's from you. Make them smile! Pop in their email address and send right away.") unless ExplanationText.find_by(section_name: 'Glow Gift').present?

ExplanationText.find_or_create_by(section_name: 'Become a Glowgetter', value: "Become a Glowgetter Start your skin journey by booking an Online Skin Consultation. Track your journey, get unlimited support and advice in our open chat forums and a Skin Expert at a tap of a button.") unless ExplanationText.find_by(section_name: 'Become a Glowgetter').present?

## Explanation texts for consultation

ExplanationText.find_or_create_by(section_name: 'Consultation Form', value: "Monica Tolan Beauty & Skincare Clinics Skin Consultation form" +
  "How it works The cost of your consultation is €50, this includes The Skin Experts Time and recommendations. Once you invest in your products from our online store you will automatically subscribe to SkinDeep By Corinna Tolan to become a Glowgetter for 6 months." +
  "Here you will keep a daily diary of your skincare and supplements as well as take weekly photos. Your Skin Expert will closely monitor your diary and be available to private message at any time for 6 weeks. You can ask questions on chat forum or educate yourself by viewing our product library. We are commited to your journey.") unless ExplanationText.find_by(section_name: 'Consultation Form').present?

ExplanationText.find_or_create_by(section_name: 'Consultation', value: "Our Online Skin Consultations Over 5 years ago, we were the first team of skincare professionals to offer a virtual consultation service." +
  "We continue to lead the way in this field. Today our online skin consultation with you will extend for 6 months at least, and hopefully a lifetime. Over 40 years of helping our clients achieve beautiful healthy skin has taught us that the key to long term results are:" +
  "Education Consistency Support Accoutability We will take you by the hand, and lead you on a journey to healthy skin that will age well.") unless ExplanationText.find_by(section_name: 'Consultation').present?

puts "****************************** Completed creating explanation text records ***********************"