class AgendaViewController < UIViewController
  attr_accessor :dataSource

  def viewDidAppear(animated)
    App.delegate.backend.getObjectsAtPath("/api/session",
                                          parameters: nil,
                                          success: lambda do |operation, result|
                                            @session = result.array
                                            self.dataSource = @session
                                            self.view.reloadData
                                          end,
                                          failure: lambda do |operation, error|
                                            puts error.localizedDescription
                                          end)

    self.navigationController.navigationBar.styleId = "nav_bar"
    self.title = "Agenda"

  end

  # RestKit callback
  def objectLoader(object_loader, didLoadObjects:session)
    @session = session
    self.view.reloadData
  end

  def tableView(tv, numberOfRowsInSection:section)
    self.dataSource.count
    #@people.count
  end

  def tableView(tv, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= 'AgendaCell'

    cell = tv.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      AgendaViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    agenda_session = self.dataSource[indexPath.row]
    cell.setupTalk(agenda_session)

    cell
  end

  def prepareForSegue(segue, sender:sender)
    row = self.view.indexPathForSelectedRow.row
    selectedSession = @session[row]
    segue.destinationViewController.model = selectedSession
  end

  def tableView(tv, heightForRowAtIndexPath:indexPath)
    60 # fixed size
  end

  def viewDidLoad
    super

    @session = []
    #self.dataSource = ("A".."Z").to_a
    self.dataSource = @session

    self.title= "Agenda"
  end
end