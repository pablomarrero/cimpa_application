require 'test_helper'

class PresentationsControllerTest < ActionController::TestCase
  setup do
    @presentation = presentations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presentations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create presentation" do
    assert_difference('Presentation.count') do
      post :create, presentation: { average_time_scientific: @presentation.average_time_scientific, completely_read: @presentation.completely_read, confirmation_completely_read: @presentation.confirmation_completely_read, courses: @presentation.courses, day_time_scientific: @presentation.day_time_scientific, how_much_cimpa: @presentation.how_much_cimpa, how_much_cimpa_percentage: @presentation.how_much_cimpa_percentage, infrastructure: @presentation.infrastructure, local_institution_description: @presentation.local_institution_description, members_of_local_committee: @presentation.members_of_local_committee, members_of_scientific_committee: @presentation.members_of_scientific_committee, motivation: @presentation.motivation, project_type: @presentation.project_type, related_scientific_work: @presentation.related_scientific_work, research_school_title: @presentation.research_school_title, school_date_a: @presentation.school_date_a, school_date_b: @presentation.school_date_b, school_place: @presentation.school_place, scientific_content: @presentation.scientific_content, similar_project: @presentation.similar_project, subject_clasification: @presentation.subject_clasification, tentative_schedule: @presentation.tentative_schedule, user_id: @presentation.user_id, women_percentage_course: @presentation.women_percentage_course, women_percentage_local: @presentation.women_percentage_local, women_percentage_scientific: @presentation.women_percentage_scientific, young_people: @presentation.young_people }
    end

    assert_redirected_to presentation_path(assigns(:presentation))
  end

  test "should show presentation" do
    get :show, id: @presentation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @presentation
    assert_response :success
  end

  test "should update presentation" do
    patch :update, id: @presentation, presentation: { average_time_scientific: @presentation.average_time_scientific, completely_read: @presentation.completely_read, confirmation_completely_read: @presentation.confirmation_completely_read, courses: @presentation.courses, day_time_scientific: @presentation.day_time_scientific, how_much_cimpa: @presentation.how_much_cimpa, how_much_cimpa_percentage: @presentation.how_much_cimpa_percentage, infrastructure: @presentation.infrastructure, local_institution_description: @presentation.local_institution_description, members_of_local_committee: @presentation.members_of_local_committee, members_of_scientific_committee: @presentation.members_of_scientific_committee, motivation: @presentation.motivation, project_type: @presentation.project_type, related_scientific_work: @presentation.related_scientific_work, research_school_title: @presentation.research_school_title, school_date_a: @presentation.school_date_a, school_date_b: @presentation.school_date_b, school_place: @presentation.school_place, scientific_content: @presentation.scientific_content, similar_project: @presentation.similar_project, subject_clasification: @presentation.subject_clasification, tentative_schedule: @presentation.tentative_schedule, user_id: @presentation.user_id, women_percentage_course: @presentation.women_percentage_course, women_percentage_local: @presentation.women_percentage_local, women_percentage_scientific: @presentation.women_percentage_scientific, young_people: @presentation.young_people }
    assert_redirected_to presentation_path(assigns(:presentation))
  end

  test "should destroy presentation" do
    assert_difference('Presentation.count', -1) do
      delete :destroy, id: @presentation
    end

    assert_redirected_to presentations_path
  end
end
