class SchoolsController < ApplicationController
  
before_filter :authenticate_user!
  skip_before_filter  :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!

  
autocomplete :school, :name

end
