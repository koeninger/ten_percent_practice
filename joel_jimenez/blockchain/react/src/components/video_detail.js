import React from 'react';

const VideoDetail = ({video}) => {
	if (!video){
		return (
			<div>
				<p>Loading...</p>
			</div>
		);
	}
	const videoTitle = video.snippet.title;
	const videoDescription = video.snippet.description;
	const videoUrl = `https://www.youtube.com/embed/${video.id.videoId}`;

	return (
		<div className="section">
			<div className="card">
				<div className="card-header">
					<p className="card-header-title">{videoTitle}</p>
				</div>
				<div className="card-content">
					<div className="section has-text-centered">
						<iframe src={videoUrl} width="100%" height="100%"></iframe>
					</div>
				</div>
				<div className="card-footer">
					<p className="card-footer-item">{videoDescription}</p>
				</div>
			</div>
		</div>
	);
};

export default VideoDetail;