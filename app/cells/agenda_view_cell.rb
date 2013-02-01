class AgendaViewCell < UITableViewCell
  extend IB

  outlet :agenda_session_label, UILabel

  def setupTalk(agenda_session)
    self.agenda_session_label.text = agenda_session.name
  end
end
