class SpeakersViewController < UIViewController
  attr_accessor :dataSource

  # RestKit callback
  def objectLoader(object_loader, didLoadObjects:participants)
    @participants = participants
    self.view.reloadData
  end

  def tableView(tv, numberOfRowsInSection:section)
    self.dataSource.count
    #@people.count
  end

  def tableView(tv, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= 'ParticipantCell'

    cell = tv.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      ParticipantViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    agenda_session = self.dataSource[indexPath.row]
    cell.setupCell(agenda_session)

    cell
  end

  def prepareForSegue(segue, sender:sender)
    row = self.view.indexPathForSelectedRow.row
    selectedSession = @participants[row]
    segue.destinationViewController.model = selectedSession
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end

  def tableView(tv, heightForRowAtIndexPath:indexPath)
    60 # fixed size
  end

  def viewDidLoad
    super

    @participants = []
    #self.dataSource = ("A".."Z").to_a
    self.dataSource = @participants

    App.delegate.backend.getObjectsAtPath("/api/participant",
                                          parameters: nil,
                                          success: lambda do |operation, result|
                                            @participants = result.array
                                            self.dataSource = @participants
                                            self.view.reloadData
                                          end,
                                          failure: lambda do |operation, error|
                                            puts error.localizedDescription
                                          end)

    self.navigationController.navigationBar.styleId = "nav_bar"
  end
end