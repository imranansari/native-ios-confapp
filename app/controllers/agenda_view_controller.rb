class AgendaViewController < UIViewController
  attr_accessor :dataSource

  def tableView(tv, numberOfRowsInSection:section)
    self.dataSource.count
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

  def tableView(tv, heightForRowAtIndexPath:indexPath)
    115 # fixed size
  end

  def viewDidLoad
    super

    self.dataSource = ("A".."Z").to_a
    self.title= "Agenda"
  end
end