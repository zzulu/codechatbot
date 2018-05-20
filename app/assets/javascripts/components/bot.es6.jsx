class Bot extends React.Component {
  render () {
    return (
      <div className="row">
        <div className="col-3">
          {this.props.message}       
        </div>
        <div className="col-6">
          {this.props.response}
        </div>
        <div className="col-3">
          보기 수정 삭제       
        </div>
      </div>
    );
  }
}

Bot.propTypes = {
  message: PropTypes.string,
  response: PropTypes.string
};
