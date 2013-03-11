class AgendaViewController < UIViewController
  extend IB

  attr_accessor :dataSource
  outlet :days_filter, UISegmentedControl

  def viewDidLoad
    super

    @data = {}

    segmentViewAppearance = SDSegmentView.appearance
    segmentViewAppearance.setTitleColor(String.new("ba0611").to_color, forState:UIControlStateNormal)
    segmentViewAppearance.setTitleColor(UIColor.whiteColor, forState:UIControlStateSelected)


    stainViewAppearance = SDStainView.appearance
    stainViewAppearance.backgroundColor = String.new("ba0611").to_color
    stainViewAppearance.shadowColor = String.new("8a1117").to_color
    stainViewAppearance.shadowBlur = 5


    segmentedControlAppearance = SDSegmentedControl.appearance
    segmentedControlAppearance.arrowSize = 8
    segmentedControlAppearance.backgroundColor = String.new("42484e").to_color


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

    loadConferenceFromServer

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

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
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

    zdatesCollection.each { |x|
      puts x.start

    }
=end

    #sessions.sort_by &:start
    @massagedGroupedSession
  end

  def set_days_filter

    self.days_filter.removeSegmentAtIndex(0, animated: false)
    self.days_filter.removeSegmentAtIndex(0, animated: false)

    @conference_data.array.each { |conference|
      puts conference.name

      startDate = parse(conference.dateStart)
      endDate = parse(conference.dateEnd)

      secondsBetween = endDate.timeIntervalSinceDate(startDate)
      numberOfDays = secondsBetween / 86400
      puts numberOfDays

      for i in 1..numberOfDays
        dt = startDate.delta(days: i)
        puts dt
        self.days_filter.insertSegmentWithTitle(dt.string_with_format("MMM/dd"), atIndex: i+1, animated: true)
      end


=begin
      puts conference.location.latitude
      puts conference.location.address.address1
=end

      puts "data loaded"
      App.delegate.conferenceModel = conference

      #NSNotificationCenter.defaultCenter.postNotificationName("location_info", object:conference.location.address)

    }

    #self.days_filter.removeSegmentAtIndex(0, animated: false)
    #self.days_filter.removeSegmentAtIndex(0, animated: false)

    #self.days_filter.insertSegmentWithTitle("Title Only", atIndex: 0, animated: true)
  end

  def loadConferenceFromServer

    App.delegate.backend.getObjectsAtPath("/api/conference",
                                          parameters: nil,
                                          success: lambda do |operation, result|
                                            @conference_data = result
                                            set_days_filter()
                                            self.view.reloadData
                                          end,
                                          failure: lambda do |operation, error|
                                            puts error.localizedDescription

                                          end)

  end


  def parse(string)
    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = "yyyy-MM-dd"
    date_formatter.dateFromString string
  end

=begin
  def numberOfDaysUntil(aDate)
    NSCalendar *gregorianCalendar = NSCalendar.alloc.initWithCalendarIdentifier:NSGregorianCalendar

    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:aDate options:0];

    return [components day];
  }
=end

end