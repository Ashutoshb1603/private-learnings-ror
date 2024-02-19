puts "****************************** Started creating consultation type records ***********************"

ConsultationType = BxBlockConsultation::ConsultationType

ConsultationType.find_or_create_by(name: 'Online Skin Consultation', price: '50', description: "Our aim is to reach your skincare goals in the shortest time frame possible. We will treat skin problem while educating and empowering you with the knowledge you need to do this." +
  "We will prioritise your product recommendations so you can work within your budget." +
  "Once you purchase your products from our online shop you will become a Glowgetter. Giving you access to unlimited product educational videos, and group forums to keep you on course." +
  "We will supervise your daily diary and monitor your progression photos to ensure we are on path. You choose to invest in us and we are invested in you.") unless ConsultationType.find_by(name: 'Online Skin Consultation').present?

  ConsultationType.find_or_create_by(name: 'Teen Skin Consultation', price: '50', description: "The teenage years are pivotal in creating good skincare habits." +
    "By educating and empowering our young adults, we give them the choice of healthy skin for a lifetime." +
    "The teenage years will bring fluctuating hormones, which may incur breakouts. We will guide our clients through this turbulent time, with an aim to reduce breakouts and minimise the potential to scar.") unless ConsultationType.find_by(name: 'Teen Skin Consultation').present?
  
  ConsultationType.find_or_create_by(name: 'Next Step Consultation', price: '25', description: "By now we may have already addressed your original concerns or maybe you would like to involve some more products to augment your results. Book a next step consultation today and we will expertly guide you forward.") unless ConsultationType.find_by(name: 'Next Step Consultation').present?
  
  ConsultationType.find_or_create_by(name: 'Pregnancy Consultation', price: '50', description: "Congratulations! What a special time in your life. During the 40 weeks for pregnancy, your skin may require a revised protocol and adjustments. Touch base with our Skin Expert today and we will take all the worry away by adapting your supplements and skincare according to your requirements.") unless ConsultationType.find_by(name: 'Pregnancy Consultation').present?
  
puts "****************************** Completed creating consultation type records ***********************"
