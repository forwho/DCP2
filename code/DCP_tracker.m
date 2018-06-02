function DCP_tracker(subFile, opt)
  mfilePath=mfilename('fullpath');
  filesepIndex=regexp(mfilePath,filesep);
  parentPath=mfilePath(1:filesepIndex(length(filesepIndex)-1));
  if ~isempty(regexp(computer,'PCWIN'))
      trackerPath=[parentPath filesep 'winexe' filesep 'dti_tracker.exe'];
  elseif ~isempty(regexp(computer,'GLNXA'))
      trackerPath=[parentPath filesep 'linexe' filesep 'dti_tracker'];
  else
      trackerPath=[parentPath filesep 'macexe' filesep 'dti_tracker'];
  end
  if strcmp(opt.swap, 'no swap')
    system([trackerPath ' ' subFile filesep 'DCP_DTI_DATA' filesep 'dti ' ...
        subFile filesep 'DCP_DTI_DATA' filesep 'dti_' num2str(opt.angle) '_' num2str(opt.lowFA) '_' ...
        num2str(opt.seed) '.trk -at ' num2str(opt.angle) ' -i' opt.invert ' -m '...
        subFile filesep 'DCP_DTI_DATA' filesep 'dti_fa.nii ' num2str(opt.lowFA) ' ' num2str(opt.highFA) ' -it nii'...
        ' -rseed ' num2str(opt.seed)]);
  else
      system([trackerPath ' ' subFile filesep 'DCP_DTI_DATA' filesep 'dti ' ...
        subFile filesep 'DCP_DTI_DATA' filesep 'dti_' num2str(opt.angle) '_' num2str(opt.lowFA) '_' ...
        num2str(opt.seed) '.trk -at ' num2str(opt.angle) ' -i' opt.invert ' -' opt.swap ' -m '...
        subFile filesep 'DCP_DTI_DATA' filesep 'dti_fa.nii ' num2str(opt.lowFA) ' ' num2str(opt.highFA) ' -it nii'...
        ' -rseed ' num2str(opt.seed)]);
  end
end