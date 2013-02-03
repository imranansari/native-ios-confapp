class AgendaViewCell < UITableViewCell
  extend IB

  outlet :agenda_session_label, UILabel
  outlet :session_slot_label, UILabel

  def setupTalk(agenda_session)
    puts agenda_session.presentation["title"]
    self.agenda_session_label.text = agenda_session.title
    self.session_slot_label.text = agenda_session.slot
  end
end
