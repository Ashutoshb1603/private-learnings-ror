puts "****************************** Started creating consultation form questions records ***********************"

SkinQuiz = BxBlockFacialtracking::SkinQuiz

SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 41, question: 'Are you currently taking any Medication prescribed by a GP or any other practitioner?') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 41).present?

SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 42, question: 'Have you any known allergies, e.g. Asprin?') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 42).present?

SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 43, question: 'Have you ever reacted to a product or treatment in the past? (if yes state which product/treatment)') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 43).present?

treatment_question = SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 44, allows_multiple: true, question: 'Have you recently been treated with or currently using any of the following?') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 44).present?
treatment_question&.choices&.find_or_create_by(choice: 'Topical Corticosteroids')
treatment_question&.choices&.find_or_create_by(choice: 'Topical Vitamin A (e.g. Differin/Adapalene/Retin A)')
treatment_question&.choices&.find_or_create_by(choice: 'Antibiotics')
treatment_question&.choices&.find_or_create_by(choice: 'Any other Acne Treatment or product')
treatment_question&.choices&.find_or_create_by(choice: 'None of these')

medicine_question = SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 45, question: 'Have you taken Roaccutane (Isotretinion) in the last 6-12 months?') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 45).present?
medicine_question&.choices&.find_or_create_by(choice: 'Yes')
medicine_question&.choices&.find_or_create_by(choice: 'No')

pregnancy_question = SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 46, question: 'Are you currently pregnant, planning a pregnancy or breastfeeding?') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 46).present?
pregnancy_question&.choices&.find_or_create_by(choice: 'Yes')
pregnancy_question&.choices&.find_or_create_by(choice: 'No')
pregnancy_question&.choices&.find_or_create_by(choice: 'BF')

SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 47, question: 'What would you like to achieve from your consultation? Please list your key skin goals in order of importance') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 47).present?

SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 48, question: 'What is your current Skincare Routine? (please give us the full details, let us know what brand and products you are using and when you are using these products - morning/evening/weekly etc.)') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 48).present?

SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 49, question: 'What supplements are you currently taking?') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 49).present?

SkinQuiz.find_or_create_by(question_type: 'consultation', seq_no: 50, question: 'Next we need some photographs of your lovely skin so we can really guide you accurately - Ideally these need to be of cleansed skin in good natural light and in good focus highlighting your key areas of concern -') unless SkinQuiz.find_by(question_type: 'consultation', seq_no: 50).present?

puts "****************************** Completed creating consultation form questions records ***********************"
