task generate_subject_question: :environment do
  # Subjects
  5.times do
    name  = Faker::Name.name
    description = Faker::Lorem.sentence
    Subject.create! name: name, description: description,
      duration: 5, number_of_questions: 5
  end

  # Questions
  subjects = Subject.order(:created_at).take 5
  subjects.each do |subject|
    10.times do
      content = Faker::Lorem.sentence
      #single choice
      right_answer = rand(0..2)
      question = Question.new content: content,
        subject: subject, state: :active, question_type: rand(0..1)
      3.times do |i|
        answer_content = Faker::Lorem.sentence
        answer = Answer.new content: answer_content,
          is_correct: i == right_answer
        question.answers << answer
      end
      question.save

      #text question
      text_question = Question.new content: content, subject: subject,
        state: rand(0..3), question_type: :text
      text_answer = Answer.new content: content, is_correct: true
      text_question.answers << text_answer
      text_question.save
    end
  end
end


