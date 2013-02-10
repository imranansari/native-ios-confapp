class AgendaViewController < UIViewController
  attr_accessor :dataSource

  def viewDidLoad
    super

    @data = {}

    App.delegate.backend.getObjectsAtPath("/api/session",
                                          parameters: nil,
                                          success: lambda do |operation, result|
                                            @data = getSessions(result)
                                            self.dataSource = @data

                                            self.view.reloadData
                                          end,
                                          failure: lambda do |operation, error|
                                            puts error.localizedDescription
                                          end)
  end

  def viewDidAppear(animated)

    self.navigationController.navigationBar.styleId = "nav_bar"
    self.title = "Agenda"

    #CYAlert.show
  end

  def sections
    @data.keys.sort
  end

  def rows_for_section(section_index)
    @data[self.sections[section_index]]
  end

  def row_for_index_path(index_path)
    rows_for_section(index_path.section)[index_path.row]
  end

  def tableView(tableView, titleForHeaderInSection: section)
    sections[section]
  end

  def numberOfSectionsInTableView(tableView)
    self.sections.count
  end

  def tableView(tableView, numberOfRowsInSection: section)
    rows_for_section(section).count
  end

  def tableView(tv, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'AgendaCell'

    cell = tv.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      AgendaViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    end

    agenda_session = row_for_index_path(indexPath)
    cell.setupTalk(agenda_session)

    cell
  end

  def prepareForSegue(segue, sender: sender)
    selectedSession = row_for_index_path(self.view.indexPathForSelectedRow)
    segue.destinationViewController.model = selectedSession
  end


=begin
  def tableView(tableView, heightForHeaderInSection: section)
    30
  end
=end

=begin
  def tableView(tableView, viewForHeaderInSection: section)

    view = UIView.alloc.init
    view.setBackgroundColor("#E9E3D6".to_color)

    sectionLabel = UILabel.alloc.initWithFrame(CGRectMake(255, 75, 60, 30))
    sectionLabel.backgroundColor = UIColor.clearColor
    sectionLabel.text= "test"
    sectionLabel.textColor = UIColor.blackColor

    #view.addSubview(sectionLabel)

  end
=end


  #helpers
  def getSessions(result)
    sessions = result.array.sort_by &:start

    groupedSession = sessions.group_by { |session| session.start }
    @massagedGroupedSession = {}
    #puts groupedSession

    groupedSession.each_pair do |k, v|
      startTime = Time.iso8601(k).strftime('%I:%M%p')
      @massagedGroupedSession[startTime] = v
    end

    #puts groupedSession.keys.size

=begin
    datesCollection = sessions.uniq { |x| x.start }

    datesCollection.each { |x|
      puts x.start

    }
=end

    #sessions.sort_by &:start
    @massagedGroupedSession
  end
end