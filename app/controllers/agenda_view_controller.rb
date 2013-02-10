class AgendaViewController < UIViewController
  attr_accessor :dataSource

  def viewDidLoad
    super

    @data = {}

    App.delegate.backend.getObjectsAtPath("/api/session",
                                          parameters: nil,
                                          success: lambda do |operation, result|
                                            @data =  getSessions(result)
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

  def tableView(tableView, titleForHeaderInSection:section)
    sections[section]
  end

  def numberOfSectionsInTableView(tableView)
    self.sections.count
  end

  def tableView(tableView, numberOfRowsInSection: section)
    rows_for_section(section).count
  end

=begin
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell = UITableViewCell.alloc.initWithStyle(
        UITableViewCellStyleDefault,
        reuseIdentifier:@reuseIdentifier)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator


    cell.textLabel.text = row_for_index_path(indexPath).title
    #cell.textLabel.text = "test"

    cell
  end
=end

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
    row = self.view.indexPathForSelectedRow.row
    puts row

    selectedSession = row_for_index_path(self.view.indexPathForSelectedRow)
    puts selectedSession
    segue.destinationViewController.model = selectedSession
  end




  #helpers
  def getSessions(result)
  sessions = result.array

  groupedSession = sessions.group_by { |session| session.start }
  @massagedGroupedSession = {}
  #puts groupedSession

    groupedSession.each_pair do |k,v|
      @massagedGroupedSession[k] = v
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