namespace :set_pre_proposals_date_as_today do
  desc "set pre_proposal_date in all proposals as today (otherwise, preproposals don't show country)"
  task default: :environment do
    Presentation.all.map {|presentation| presentation.update(:pre_proposal_date => DateTime.current)}
  end
end
