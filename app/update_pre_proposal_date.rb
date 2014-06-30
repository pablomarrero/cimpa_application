#!/usr/bin/env /usr/local/bin/rails runner
Presentation.all.map {|presentation| presentation.update(:pre_proposal_date => DateTime.current)}
