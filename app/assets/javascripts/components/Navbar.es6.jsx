class Navbar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      activeUsers: this.props.controller === 'devise/registrations' ? 'active':''
    }
  }

  render() {
    return (
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
        <a className="navbar-brand" href={this.props.rootPath}>{this.props.languageKo} 챗봇</a>
        <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
          <span className="navbar-toggler-icon"></span>
        </button>
        <div className="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
          <ul className="navbar-nav">
            <li className={`nav-item ${this.state.activeUsers}`}>
              <a className="nav-link" href={this.props.editUserRegistrationPath}>{ this.props.username}</a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href={this.props.destroyUserSessionPath} data-method="delete">로그아웃</a>
            </li>
          </ul>
        </div>
      </nav>
    );
  }
}

Navbar.propTypes = {
  root_path: PropTypes.string,
  edit_user_registration_path: PropTypes.string,
  destroy_user_session_path: PropTypes.string,
  controller: PropTypes.string,
  username: PropTypes.string,
  languageKo: PropTypes.string,
}
