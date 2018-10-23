class CleanNavbar extends React.Component {
  render() {
    return (
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
        <a className="navbar-brand" href={this.props.rootPath}>{this.props.languageKo} 챗봇</a>
      </nav>
    );
  }
}

CleanNavbar.propTypes = {
  rootPath: PropTypes.string,
  languageKo: PropTypes.string,
}
